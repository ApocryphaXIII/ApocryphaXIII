import { map } from 'common/collections';
import { Button, Section, Table } from 'tgui-core/components';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';

export const NtosCrewManifest = (props) => {
  const { act, data } = useBackend();
  const { have_printer, manifest = {} } = data;
  return (
    <NtosWindow width={400} height={480} resizable>
      <NtosWindow.Content scrollable>
        <Section
          title="Crew Manifest"
          buttons={
            <Button
              icon="print"
              content="Print"
              disabled={!have_printer}
              onClick={() => act('PRG_print')}
            />
          }
        >
          {map((entries, department) => (
            <Section key={department} level={2} title={department}>
              <Table>
                {entries.map((entry) => (
                  <Table.Row key={entry.name} className="candystripe">
                    <Table.Cell bold>{entry.name}</Table.Cell>
                    <Table.Cell>({entry.rank})</Table.Cell>
                  </Table.Row>
                ))}
              </Table>
            </Section>
          ))(manifest)}
        </Section>
      </NtosWindow.Content>
    </NtosWindow>
  );
};
