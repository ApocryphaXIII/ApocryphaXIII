import { sortBy } from 'common/collections';
import { Button, Flex, Section, Stack, Tabs } from 'tgui-core/components';

import { useLocalState } from '../../backend';

const diffMap = {
  0: {
    icon: 'times-circle',
    color: 'bad',
  },
  1: {
    icon: 'stop-circle',
    color: null,
  },
  2: {
    icon: 'check-circle',
    color: 'good',
  },
};

export const AccessList = (props) => {
  const {
    accesses = [],
    selectedList = [],
    accessMod,
    grantAll,
    denyAll,
    grantDep,
    denyDep,
  } = props;
  const [selectedAccessName, setSelectedAccessName] = useLocalState(
    'accessName',
    accesses[0]?.name,
  );
  const selectedAccess = accesses.find(
    (access) => access.name === selectedAccessName,
  );
  const selectedAccessEntries = sortBy((entry) => entry.desc)(
    selectedAccess?.accesses || [],
  );

  const checkAccessIcon = (accesses) => {
    let oneAccess = false;
    let oneInaccess = false;
    for (let element of accesses) {
      if (selectedList.includes(element.ref)) {
        oneAccess = true;
      } else {
        oneInaccess = true;
      }
    }
    if (!oneAccess && oneInaccess) {
      return 0;
    } else if (oneAccess && oneInaccess) {
      return 1;
    } else {
      return 2;
    }
  };

  return (
    <Section
      title="Access"
      buttons={
        <>
          <Button
            icon="check-double"
            content="Grant All"
            color="good"
            onClick={() => grantAll()}
          />
          <Button
            icon="undo"
            content="Deny All"
            color="bad"
            onClick={() => denyAll()}
          />
        </>
      }
    >
      <Flex>
        <Flex.Item>
          <Tabs vertical>
            {accesses.map((access) => {
              const entries = access.accesses || [];
              const icon = diffMap[checkAccessIcon(entries)].icon;
              const color = diffMap[checkAccessIcon(entries)].color;
              return (
                <Tabs.Tab
                  key={access.name}
                  altSelection
                  color={color}
                  icon={icon}
                  selected={access.name === selectedAccessName}
                  onClick={() => setSelectedAccessName(access.name)}
                >
                  {access.name}
                </Tabs.Tab>
              );
            })}
          </Tabs>
        </Flex.Item>
        <Flex.Item grow={1}>
          <Stack>
            <Stack.Item mr={0}>
              <Button
                fluid
                icon="check"
                content="Grant Region"
                color="good"
                onClick={() => grantDep(selectedAccess.regid)}
              />
            </Stack.Item>
            <Stack.Item ml={0}>
              <Button
                fluid
                icon="times"
                content="Deny Region"
                color="bad"
                onClick={() => denyDep(selectedAccess.regid)}
              />
            </Stack.Item>
          </Stack>
          {selectedAccessEntries.map((entry) => (
            <Button.Checkbox
              fluid
              key={entry.desc}
              content={entry.desc}
              checked={selectedList.includes(entry.ref)}
              onClick={() => accessMod(entry.ref)}
            />
          ))}
        </Flex.Item>
      </Flex>
    </Section>
  );
};
