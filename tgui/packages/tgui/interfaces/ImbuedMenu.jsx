import { Box, Button, LabeledList, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const ImbuedMenu = (props) => {
  const { act, data } = useBackend();
  const { abilities } = data;
  return (
    <Window width={900} height={480} resizable>
      <Window.Content scrollable>
        <Section>
          <LabeledList>
            <LabeledList.Item
              label="XP"
              buttons={
                <Button
                  icon="undo"
                  content="Readapt"
                  disabled={!data.can_readapt}
                  onClick={() => act('readapt')}
                />
              }
            >
              {data.xp}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section>
          <LabeledList>
            {abilities.map((ability) => (
              <LabeledList.Item
                key={ability.name}
                className="candystripe"
                label={ability.name}
                buttons={
                  <>
                    {ability.dna_cost}{' '}
                    <Button
                      content={ability.owned ? 'Evolved' : 'Evolve'}
                      selected={ability.owned}
                      onClick={() =>
                        act('evolve', {
                          path: ability.path,
                        })
                      }
                    />
                  </>
                }
              >
                {ability.desc}
                <Box color="good">{ability.helptext}</Box>
              </LabeledList.Item>
            ))}
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
